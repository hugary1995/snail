#!/usr/bin/env python

import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from pathlib import Path

if __name__ == "__main__":
    fig, ax = plt.subplots()

    # Full 3D model
    hs = []
    fs = []
    for file in Path(".").glob("cartesian_3D_*.csv"):
        result = pd.read_csv(file)
        hs.append(float(file.stem.split("_")[-1]))
        fs.append(result["force"].iloc[-1] / hs[-1])
    hs = np.array(hs)
    fs = np.array(fs)
    ind = np.argsort(hs)
    ax.plot(hs[ind], fs[ind], "ko--", label="3D")
    ax.set_xscale("log")

    # Plane strain
    result = pd.read_csv("cartesian_2D_plane_strain.csv")
    f = result["force"].iloc[-1]
    ax.hlines(f, np.min(hs), np.max(hs), colors="r", label="2D plane strain")

    # Plane stress
    result = pd.read_csv("cartesian_2D_weak_plane_stress.csv")
    f = result["force"].iloc[-1]
    ax.hlines(f, np.min(hs), np.max(hs), colors="b", label="2D weak plane stress")

    ax.set_xlabel("thickness (mm)")
    ax.set_ylabel("force (N/mm)")
    ax.legend(bbox_to_anchor=(0.4, 0.7))

    fig.tight_layout()
    fig.savefig("comparison.png")
