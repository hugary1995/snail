#!/usr/bin/env python

from pathlib import Path
import shutil
import subprocess

pwd = Path(".")
ex_dirs = ["include", "src", "tutorials"]
out_dir = Path("notes")
language = {".h": "cpp", ".C": "cpp", ".i": "python"}
skip = [
    "include/base/ADComputeDeformationGradient.h",
    "src/base/ADComputeDeformationGradient.C",
    "include/base/snailApp.h",
    "src/base/snailApp.C",
    "src/main.C",
]

if __name__ == "__main__":
    if not shutil.which("enscript"):
        raise Exception(
            "'enscript' will be used to convert source code to PostScript, but it cannot be found in PATH."
        )
    if not shutil.which("ps2pdf"):
        raise Exception(
            "'ps2pdf' will be used to convert PostScript to PDF, but it cannot be found in PATH."
        )

    if out_dir.exists():
        shutil.rmtree(out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    for ex_dir in ex_dirs:
        for file in Path(ex_dir).rglob("*"):
            if file.is_dir():
                continue
            if file.suffix not in language:
                continue
            if str(file.relative_to(pwd)) in skip:
                continue

            ofile = out_dir / str(file.relative_to(ex_dir)).replace("/", "_")

            # source code to PS
            ofile.parent.mkdir(parents=True, exist_ok=True)
            args = [
                "enscript",
                "-o",
                str(ofile) + ".ps",
                "-E{}".format(language[file.suffix]),
                "--color",
                "-M",
                "Letter",
                str(file),
            ]
            print(" ".join(args))
            subprocess.run(
                args, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
            )

            # PS to pdf
            args = [
                "ps2pdf",
                str(ofile) + ".ps",
                str(ofile) + ".pdf",
            ]
            print(" ".join(args))
            subprocess.run(
                args, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
            )

            print("-" * 79)
