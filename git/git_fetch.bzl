# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under both the MIT license found in the
# LICENSE-MIT file in the root directory of this source tree and the Apache
# License, Version 2.0 found in the LICENSE-APACHE file in the root directory
# of this source tree.

_HEX_DIGITS = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]

def _is_40_hex(rev: str) -> bool:
    if len(rev) != 40:
        return False
    for digit in rev.elems():
        if digit not in _HEX_DIGITS:
            return False
    return True

def _project_output(out: Artifact, path: str) -> Artifact:
    if path == ".":
        return out
    elif path.endswith("/"):
        return out.project(path[:-1], hide_prefix = True)
    else:
        return out.project(path, hide_prefix = True)

def git_fetch_impl(ctx: AnalysisContext) -> list[Provider]:
    rev = ctx.attrs.rev
    if not _is_40_hex(rev):
        fail("git_fetch's `rev` must be a 40-hex-digit commit hash: {}".format(rev))

    git_dir = ctx.actions.declare_output(".git", dir = True)

    short_path = ctx.attrs.name.removesuffix(".git")
    if not short_path:
        short_path = "work-tree"
    work_tree = ctx.actions.declare_output(short_path, dir = True)

    # declare sub targets from attrs
    sub_targets = {name: [DefaultInfo(default_outputs = [_project_output(work_tree,name)])] for name in ctx.attrs.sub_targets}

    cmd = [
        ctx.attrs._git_fetch_tool[RunInfo],
        cmd_args("--git-dir=", git_dir.as_output(), delimiter = ""),
        cmd_args("--work-tree=", work_tree.as_output(), delimiter = ""),
        cmd_args("--repo=", ctx.attrs.repo, delimiter = ""),
        cmd_args("--rev=", rev, delimiter = ""),
    ]

    ctx.actions.run(
        cmd,
        category = "git_fetch",
        local_only = True,
        no_outputs_cleanup = True,
    )

    return [DefaultInfo(
        default_output = work_tree,
        sub_targets = sub_targets,
    )]
