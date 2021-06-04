# Export AWS AK / SK for deploy codei (awscli)
# export AWS_ACCESS_KEY_ID=
# export AWS_SECRET_ACCESS_KEY=
# Remplacez "gitlab-examen-test" par "gitlab-examen-VOTRE_GROUP_ID"
code_test:
	python -m unittest discover
code_release:
	zip lambda_function.zip index.py
# Le déployement doit s'effectuer uniquement sur la branche master
code_deploy:
	aws s3 cp lambda_function.zip s3://gitlab-examen-test/
	aws lambda update-function-code --function-name gitlab-examen-test --s3-bucket gitlab-examen-test --s3-key lambda_function.zip
