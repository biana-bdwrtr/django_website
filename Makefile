tag=latest
organization=bdwrtr
image=bdwrtr-django-tutorial
repository=django-website

build:
	docker build --force-rm $(options) -t $(image):latest .

build-prod:
	$(MAKE) build options="--target production"

push:
	docker tag $(image):latest $(organization)/$(repository):$(tag)
	docker push $(organization)/$(repository):$(tag)

compose-start:
	docker-compose up --remove-orphans $(options)

compose-stop:
	docker-compose down --remove-orphans $(options)

compose-manage-py:
	docker-compose run --rm $(options) website python manage.py $(cmd)

start-server:
	python manage.py runserver 0.0.0.0:80

helm-deploy:
	helm upgrade --install django-tutorial ./helm/django-website