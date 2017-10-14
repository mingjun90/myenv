#!/bin/bash

if [ ! -d ~/myenv ]; then
    mkdir ~/myenv
fi
cd ~/myenv
MYENV_PATH=`pwd`

if [ ! -d $MYENV_PATH/python3.6 ]; then
    mkdir -p $MYENV_PATH/python3.6
    echo "install python3.6 to locall path"
    wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz
    tar -xf Python-3.6.0.tgz
    cd $MYENV_PATH/Python-3.6.0
    #./configure --prefix=/home/${USER}/myenv/python3.6

    echo "quietly install.."
    ./configure --prefix=$MYENV_PATH/python3.6 --quiet
    make --quiet
    make --quiet install
    echo "python3.6 installed"

    if [ -d $MYENV_PATH/Python-3.6.0 ]; then
        echo 'clean(1/2): remove Python-3.6.0'
        rm -r $MYENV_PATH/Python-3.6.0
    fi
    if [ -f $MYENV_PATH/Python-3.6.0.tgz ]; then
        echo 'clean(2/2): remove Python-3.6.0.tgz'
        rm $MYENV_PATH/Python-3.6.0.tgz
    fi
fi


cd ~
if [ ! -d $MYENV_PATH/py3 ]; then
    echo "create virtual env for python3.6"
    $MYENV_PATH/python3.6/bin/python3.6 -m venv ENV_DIR $MYENV_PATH/py3
    echo "py3 created"
fi

if [ -d $MYENV_PATH/py3/bin ]; then
    echo "Activate py3:"
    echo "    bash> source ~/myenv/py3/bin/activate"
    echo "    csh> source ~/myenv/py3/bin/activate.csh"
    echo "Quit py3:"
    echo "    > deactivate"
fi

echo "Add following setting into startup configuration"
echo "~/.cshrc:"
echo '    alias py3 "source ~/myenv/py3/bin/activate.csh"'
echo "~/.bashrc:"
echo '    alias py3="source ~/myenv/py3/bin/activate"'
