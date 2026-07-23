#!/usr/bin/env python3
import csv
import json
import sys
from collections import OrderedDict
from pathlib import Path


def main() -> int:
    if len(sys.argv) != 3:
        print("usage: generate_imdf_category_catalog_json.py <categories_csv> <output_json>", file=sys.stderr)
        return 2

    csv_path = Path(sys.argv[1])
    output_path = Path(sys.argv[2])
    entries_by_id: OrderedDict[str, dict[str, str]] = OrderedDict()

    with csv_path.open(newline="", encoding="utf-8-sig") as csv_file:
        reader = csv.DictReader(csv_file)

        for row in reader:
            feature = row["feature"].strip()
            value = row["category"].strip()
            definition = row["definition"].strip()
            entry_id = f"{feature}:{value}"

            if entry_id not in entries_by_id:
                entry = {
                    "feature": feature,
                    "value": value,
                }
                if definition:
                    entry["definition"] = definition
                entries_by_id[entry_id] = entry
            elif definition and "definition" not in entries_by_id[entry_id]:
                entries_by_id[entry_id]["definition"] = definition

    output_path.parent.mkdir(parents=True, exist_ok=True)
    with output_path.open("w", encoding="utf-8") as output_file:
        json.dump({"entries": list(entries_by_id.values())}, output_file, ensure_ascii=False, indent=2)
        output_file.write("\n")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
