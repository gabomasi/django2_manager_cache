.PHONY: clean-pyc clean-build docs clean

help:
	@echo "clean-build - remove build artifacts"
	@echo "clean-pyc - remove Python file artifacts"
	@echo "lint - check style with flake8"
	@echo "dev-requirements - install development dependencies to current environment"
	@echo "test - run tests quickly with the default Python"
	@echo "dist - package"

clean: clean-build clean-pyc
	rm -fr htmlcov/

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

lint:
	python setup.py flake8

dev-requirements:
	pip install -r requirements-dev.txt

test3:
	pip install -e .
	python tests/manage.py test

test2:
	pip3 install -e .
	python3 tests/manage.py test

test: dev-requirements test2 test3

shell: dev-requirements
	pip install -e .
	python tests/shell.py

coverage: dev-requirements
	pip install -e .
	coverage run --source=django2_manager_cache tests/manage.py test

dist: clean
	python setup.py sdist
	python setup.py bdist_wheel
	ls -l dist
