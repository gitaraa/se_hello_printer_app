.PHONY: test

deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt
#sprawdzanie poprawnosci kodu za pomoca make lint
lint:
	flake8 hello_world test
#uruchamianie testow za pomoca make lint
test:
	PYTHONPATH=. py.test  --verbose -s
test_cov:
	PYTHONPATH=. py.test --verbose -s --cov=.
	PYTHONPATH=. py.test --verbose -s --cov=. --cov-report xml
test_xunit:
	PYTHONPATH=. py.test -s --cov=. --cov-report xml --junit-xml=test_results.xml
run:
	PYTHONPATH=. FLASK_APP=hello_world flask run

docker_build:
	docker build -t hello-world-printer .

docker_run: docker_build
		docker run \
	  --name hello-world-printer-dev \
	 	 -p 5000:5000 \
		 -d hello-world-printer

USERNAME=gitaraa
TAG=$(USERNAME)/hello-hello_world_printer

docker_push: docker_build
		@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD}; \
		docker tag hello-world-printer $(TAG); \
		docker push $(TAG); \
		docker logout;
