# Must have `sentry-cli` installed globally
# Following variables must be passed in

export SENTRY_AUTH_TOKEN=c502ba048ec64d1b95aed2659567501ca7f4dcc75353483689620566d7d9b997
export SENTRY_ORG=sentry-test
export SENTRY_PROJECT=isabel-react-demo

REACT_APP_RELEASE_VERSION=`sentry-cli releases propose-version`


setup_release: create_release upload_sourcemaps associate_commits

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(REACT_APP_RELEASE_VERSION)

upload_sourcemaps:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) files $(REACT_APP_RELEASE_VERSION) \
		upload-sourcemaps --url-prefix "~/static/js" --validate build/static/js

associate_commits:
	sentry-cli releases set-commits --local $(REACT_APP_RELEASE_VERSION)