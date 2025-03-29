#!/bin/bash
cd /home/ubuntu
yes | sudo apt update
yes | sudo apt install at python3 python3-pip
git clone https://github.com/defmania/python-mysql-db-proj-2.git
sleep 20
cd python-mysql-db-proj-2
pip3 install -r requirements.txt
sleep 30
