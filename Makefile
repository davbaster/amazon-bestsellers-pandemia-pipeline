.PHONY: infra-gcp infra-local pipeline dashboard test

infra-gcp:
	cd infrastructure/gcp && terraform apply

infra-local:
	cd infrastructure/local && terraform apply

pipeline:
	bruin run

dashboard:
	streamlit run dashboard/app.py

test:
	bruin validate
	terraform fmt -check
