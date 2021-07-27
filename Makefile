
REGO=$(shell find rego -name "*.rego")
TF_TEST_INPUTS=$(shell find rego/tests -name "*.tf")
CFN_TEST_INPUTS=$(shell find rego/tests -name "*.yaml")
TEST_INPUTS=$(TF_TEST_INPUTS) $(CFN_TEST_INPUTS)

GENERATE_FLAGS =
ifeq ($(FORCE_GENERATE),1)
GENERATE_FLAGS += -f
endif

SERVICES=acm \
	amazon_mq \
	api_gateway \
	docdb \
	eks \
	elasticache \
	elasticsearch \
	neptune \
	sagemaker

venv:
	python -m venv venv
	. venv/bin/activate && pip install -r requirements.txt

.PHONY: gen
gen: venv
	python bin/generate.py $(GENERATE_FLAGS)
	$(MAKE) write-test-inputs --no-print-directory
	$(MAKE) fmt --no-print-directory

.PHONY: metadata
metadata:
	PYTHONPATH=. python bin/update_metadata.py $(SERVICES)

.PHONY: clean
clean:
	rm -rf venv

.PHONY: fmt
fmt:
	opa fmt -w $(REGO)

.PHONY: test
test: venv
	. venv/bin/activate && \
	PYTHONPATH=. py.test -vv --cov-report term-missing --cov=iac iac

.PHONY: write-test-inputs
write-test-inputs:
	regula write-test-inputs $(TEST_INPUTS)
