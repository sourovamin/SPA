from setuptools import setup, find_packages

setup(
    name='spallvm',
    version='1.0',
    packages=find_packages(include=['spa']),
    install_requires=[
        'llvmlite==0.39.1',
        'numpy',
    ],
)