## Installation

- The complete installation guide is available on the <a href="https://mooseframework.inl.gov/getting_started/installation/index.html">MOOSE website</a>.
- While there are many installation methods, the recommended way of installing MOOSE on your personal device is through <a href="https://mooseframework.inl.gov/getting_started/installation/conda.html">Conda</a>.
  - The Conda method is suitable for Linux and MacOS.
  - On Windows, first install the <a href="https://learn.microsoft.com/en-us/windows/wsl/install">Windows Subsystem for Linux (WSL)</a>, then follow the <a href="https://mooseframework.inl.gov/getting_started/installation/conda.html">Conda</a> installation method.

> Please let us know **ASAP** if you run into **any** issue during the installation process.

---

Install Conda

```shell
curl -L -O https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-XXXXXX.sh
bash Miniforge3-*.sh -b -p ~/miniforge
~/miniforge/bin/conda init --all
```

- <!-- .element: style="font-size: 1rem" --> Linux users: replace <span style="color: coral">XXXXXX</span> with <span style="color: coral">Linux-x86_64</span>
- <!-- .elementi: style="font-size: 1rem" --> Mac (Intel) users: replace <span style="color: coral">XXXXXX</span> with <span style="color: coral">MacOSX-x86_64</span>
- <!-- .element: style="font-size: 1rem" --> Mac (Apple Silicon) users: replace <span style="color: coral">XXXXXX</span> with <span style="color: coral">MacOSX-arm64</span>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;

Create environment

```shell
conda create -n moose
conda activate moose
conda install -c  https://conda.software.inl.gov/public moose-dev
```

Install MOOSE

```shell
mkdir -p ~/projects
cd ~/projects
git clone --single-branch -b master --depth 1 https://github.com/idaholab/moose.git
cd moose/test
make -j N
```

---

## Create an application

- Once MOOSE has been successfully installed, we are ready to <span style="color: coral">create our own MOOSE-based application!</span>
- For the purpose of this training, we will call our app "<span style="color: coral">snail</span>".
- Under the parent directory of MOOSE, run

```shell
./moose/scripts/stork.sh snail
```

- Finally, <span style="color: coral">enable the solid mechanics module</span> by modifying the `Makefile`:&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

```Makefile
TENSOR_MECHANICS := yes
```

- To compile `snail`, run&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;

```shell
make -j N
```
