#!/usr/bin/env python

import sys
import gmsh
from pathlib import Path
import subprocess
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt


def gen_mesh(N):
    gmsh.initialize()

    gmsh.option.setNumber("General.Terminal", 0)

    gmsh.model.add("membrane")

    A = gmsh.model.geo.addPoint(0, 0, 0)
    B = gmsh.model.geo.addPoint(0, 44, 0)
    C = gmsh.model.geo.addPoint(48, 60, 0)
    D = gmsh.model.geo.addPoint(48, 44, 0)

    AB = gmsh.model.geo.addLine(A, B)
    BC = gmsh.model.geo.addLine(B, C)
    CD = gmsh.model.geo.addLine(C, D)
    DA = gmsh.model.geo.addLine(D, A)

    ABCD = gmsh.model.geo.addCurveLoop([AB, BC, CD, DA])

    S = gmsh.model.geo.addPlaneSurface([ABCD])

    gmsh.model.geo.mesh.setTransfiniteCurve(AB, N + 1)
    gmsh.model.geo.mesh.setTransfiniteCurve(BC, N + 1)
    gmsh.model.geo.mesh.setTransfiniteCurve(CD, N + 1)
    gmsh.model.geo.mesh.setTransfiniteCurve(DA, N + 1)
    gmsh.model.geo.mesh.setTransfiniteSurface(S)
    gmsh.model.geo.mesh.setRecombine(2, S)

    gmsh.model.geo.synchronize()

    gmsh.model.addPhysicalGroup(2, [S], name="membrane")
    gmsh.model.addPhysicalGroup(1, [AB], name="left")
    gmsh.model.addPhysicalGroup(1, [CD], name="right")

    gmsh.model.mesh.generate(2)

    gmsh.write("membrane.msh".format(N))

    gmsh.finalize()


if __name__ == "__main__":
    fig, ax = plt.subplots()

    vlcs = [True, False, False]
    secs = [False, False, True]
    args = ["mpiexec", "-n", sys.argv[1], "../../snail-opt", "-i", "cook.i"]

    for vlc, sec in zip(vlcs, secs):
        print("-------------------------------------------------------")
        print("volumetric_locking_correction = {}".format(vlc))
        print("                 second_order = {}".format(sec))

        ns = np.arange(1, 16)
        us = np.empty_like(ns, dtype=float)

        for i, n in enumerate(ns):
            print("Generating mesh with {} elements per edge.".format(n), end=" ")
            print("Solving...")
            gen_mesh(n)
            subprocess.run(
                args + ["vlc={}".format(vlc), "Mesh/second_order={}".format(sec)],
                check=True,
                stdout=subprocess.DEVNULL,
            )
            result = pd.read_csv("cook_out.csv".format(n))
            us[i] = result["value"].iloc[-1]

        vlc_label = "w/ stabilization" if vlc else "w/o stabilization"
        sec_label = "QUAD8" if sec else "QUAD4"
        ax.plot(ns, us, ".--", label=" ".join([sec_label, vlc_label]))

    ax.set_xlabel("Number of elements per edge")
    ax.set_ylabel("Tip displacement (mm)")
    ax.legend()

    fig.tight_layout()
    fig.savefig("comparison.png")
