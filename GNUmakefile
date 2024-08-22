DOCKER:=docker
HELM:=helm
RM:=rm
INSTALL:=install
PUR:=pur

PKGDIR:=packages
REQS:=app/requirements.txt

all: docker helm

$(PKGDIR):
	$(INSTALL) -dm755 $@

.PHONY: helm
helm: $(PKGDIR)
	$(HELM) package --destination $(PKGDIR) charts/helm-canary

.PHONY: docker
docker:
	$(DOCKER) build .

.PHONY: upgrade
upgrade:
	cd app && $(PUR) -r requirements.txt

.PHONY: clean
clean:
	$(RM) -fr $(PKGDIR)
