PYTHON?=python3


# install joommf via pip
build-docker-pip:
	docker build -t joommfimage-pip -f Dockerfile .

# install joommf via conda
build-docker-conda:
	docker build -t joommfimage-conda -f Dockerfile-conda .

build-docker:
	make build-docker-pip
	make build-docker-conda

# push-docker: build-docker
# 	docker push joommf/joommf
#
# build-dists:
# 	rm -rf dist/
# 	$(PYTHON) setup.py sdist
# 	$(PYTHON) setup.py bdist_wheel
#
# release: build-dists
# 	twine upload dist/*

test:
	pwd
	ls -l
	oommf +version

	$(PYTHON) -c "import sys; import oommfodt as m; sys.exit(m.test())"
	$(PYTHON) -c "import sys; import joommfutil as m; sys.exit(m.test())"
	$(PYTHON) -c "import sys; import discretisedfield as d; import sys; sys.exit(d.test())"
	$(PYTHON) -c "import sys; import micromagneticmodel as m; sys.exit(m.test())"
	$(PYTHON) -c "import sys; import oommfc as m; sys.exit(m.test())"
	$(PYTHON) -c "import sys; import joommf"


travis-build:
	make build-docker
	docker run --rm -e ci_env joommfimage-pip make test
	docker run --rm -e ci_env joommfimage-conda make test
