#!/usr/bin/env python

from pathlib import Path
import shutil

file_associations = {".C": "// ", ".h": "// ", ".i": "# ", ".py": "# "}
remove_begin = "REMOVE_BEGIN"
remove_end = "REMOVE_END"


def generate(map):
    for orig, dest in map.items():
        orig = Path(orig)
        dest = Path(dest)

        if dest.exists():
            shutil.rmtree(dest)
        dest.mkdir(parents=True, exist_ok=True)

    for orig, dest in map.items():
        orig = Path(orig)
        dest = Path(dest)

        for file in orig.rglob("*"):
            out = dest / file.relative_to(orig)

            if file.is_dir():
                # Faithfully copy the gold directory
                if file.stem == "gold":
                    shutil.copytree(file, out, dirs_exist_ok=True)
                    print("Done populating", str(out))
                continue
            elif file.suffix not in file_associations:
                continue

            out.parent.mkdir(parents=True, exist_ok=True)

            # copy2 preserves permission bits
            shutil.copy2(file, out)

            with open(file) as file_to_read, open(out, "w") as file_to_write:
                remove_begin_comment = file_associations[file.suffix] + remove_begin
                remove_end_comment = file_associations[file.suffix] + remove_end

                # simple state machine to scan through lines
                should_copy = True
                for line in file_to_read:
                    if line.strip().startswith(remove_begin_comment):
                        should_copy = False

                    if should_copy:
                        file_to_write.write(line)
                    else:
                        file_to_write.write(file_associations[file.suffix] + "HIDDEN\n")

                    if line.strip().startswith(remove_end_comment):
                        should_copy = True

                print("Done populating", str(out))


if __name__ == "__main__":
    generate(
        {
            "include": "snail/include",
            "src": "snail/src",
            "tutorials": "snail/tutorials",
        }
    )
