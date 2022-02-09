1_GENERATE_GPG_KEY:
	gpg --full-generate-key
	open ~/.gnupg/

2_ENCRYPT_TEST_ENV:
	# -a: ASCII
	# -r: Key fingerpring
	# -e: Encrypt file
	# -o: Output file
	gpg -a -r 0x0BD10E4E6E578FB6 -o test_environment.env.asc -e test_environment.env

3_DECRYPT_TEST_ENV:
	# -a: ASCII
	# -r: Key fingerpring
	# -d: Encrypt file
	# -o: Output file
	gpg -a -r 0x0BD10E4E6E578FB6 -o test_environment.env -d test_environment.env.asc

4_EXPORT_CHAIN:
	# -a: ASCII
	# -r: Key fingerpring
	# -d: Encrypt file
	# -o: Output file
	gpg -a -r 0x0BD10E4E6E578FB6 -o test_environment.env -d test_environment.env.asc

5_TEST_ENV_SETUP:
	$(shell gpg -a -r 0x0BD10E4E6E578FB6 -d test_environment.env.asc)

TEST: 
	source ./test_environment.env && \
	cargo test

TEST_USER_SEARCH_LOGIC:
	cargo test -- search_by_name::full_name_search::tests::test_full_name_serach

TEST_FIND_USER:
	source ./test_environment.env && \
	cargo test -- test_find_user

TEST_MESSAGES:
	source ./test_environment.env && \
	cargo test -- test_messages

TEST_IMAGE:
	source ./test_environment.env && \
	cargo test -- test_image_upload

TEST_FORMATTED_MESSAGE:
	source ./test_environment.env && \
	cargo test -- test_formatted_message

TEST_USERS_CACHE: 
	source ./test_environment.env && \
	export RUST_LOG=trace && \
	export RUST_BACKTRACE=1 && \
	cargo test -- users_cache

TEST_USERS_JSON_CACHE: 
	source ./test_environment.env && \
	cargo test -- test_json_cache

TEST_USERS_SQLITE_CACHE: 
	source ./test_environment.env && \
	export RUST_LOG=trace && \
	export RUST_BACKTRACE=1 && \
	cargo test -- test_sqlite_cache
