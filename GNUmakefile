DOCKER:=docker
HELM:=helm
RM:=rm
INSTALL:=install

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
	pur -r $(REQS)

.PHONY: clean
clean:
	$(RM) -fr $(PKGDIR)
