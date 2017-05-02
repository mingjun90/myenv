#!/bin/bash

if [ ! -d ~/myenv ]; then
    mkdir ~/myenv
fi
cd ~/myenv

myenv_path=`pwd`
source_tarball="Python-2.7.13.tgz"
target_python="python2.7"
target_venv="py2"


if [ ! -d $myenv_path/$target_python ]; then
    echo "install $target_python to locall path"
    wget https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz
    tar -xf Python-2.7.13.tgz
    cd $myenv_path/Python-2.7.13

    echo "quietly install.."
    ./configure --prefix=$myenv_path/$target_python --quiet
    make --quiet
    make --quiet install
    echo "$target_python installed"

    if [ -d $myenv_path/Python-2.7.13 ]; then
        echo "clean(1/2): remove Python-2.7.13"
        rm -r $myenv_path/Python-2.7.13
    fi
    if [ -f $myenv_path/$source_tarball ]; then
        echo "clean(2/2): remove $source_tarball"
        rm $myenv_path/$source_tarball
    fi
fi


if [ ! -d $myenv_path/$target_venv ]; then
    echo "create virtual env for $target_python"
    cd $myenv_path
    wget https://pypi.python.org/packages/d4/0c/9840c08189e030873387a73b90ada981885010dd9aea134d6de30cd24cb8/virtualenv-15.1.0.tar.gz
    tar -xf virtualenv-15.1.0.tar.gz
    $myenv_path/virtualenv-15.1.0/virtualenv.py $myenv_path/$target_venv --python=$myenv_path/$target_python/bin/$target_python
    rm $myenv_path/virtualenv-15.1.0.tar.gz
fi


function use_guide {
    echo "Activate $target_venv:"
    echo "    bash> source $myenv_path/$target_venv/bin/activate"
    echo "    csh> source $myenv_path/$target_venv/bin/activate.csh"
    echo "Quit $target_venv:"
    echo -e "    > deactivate\n "
}

function alias_guide {
    echo "Add following setting into startup configuration"
    echo "~/.cshrc:"
    echo "    alias $target_venv \"source $myenv_path/$target_venv/bin/activate.csh\""
    echo "~/.bashrc:"
    echo "    alias $target_venv=\"source $myenv_path/$target_venv/bin/activate\""
}

if [ -d $myenv_path/$target_venv/bin ];then
    echo -e "$target_venv already installed\n"
    use_guide
    alias_guide
fi
