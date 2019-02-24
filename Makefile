.PHONY: test

deps:
	pip install -r requirements.txt;/
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

test:
	PYTHONPATH=. py.test  --verbose -s

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
TAG=$(gitaraa)/hello-hello_world_printer

docker_push:docker_build
		@docker login --username$(gitaraa) --password $${L@to1234!}; \
		docker tag hello-world-printer $(TAG);\
		docker push $(TAG); \
		docker logout;
