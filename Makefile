run:
	${MAKE} \
		json-pp-true \
		cpanel-true \
		json-pp-1 \
		cpanel-1 \
		json-pp-strigify \
		cpanel-strigify

json-pp-true:
	docker-compose run app perl -M'Test::More "no_plan"' -MJSON::PP -E 'is_deeply decode_json(qq{{"a":true}})->{a}, JSON::PP::true'

cpanel-true:
	docker-compose run app perl -M'Test::More "no_plan"' -MJSON::PP -M'Cpanel::JSON::XS ()' -E 'is_deeply decode_json(qq{{"a":true}})->{a}, JSON::PP::true'

json-pp-1:
	docker-compose run app perl -M'Test::More "no_plan"' -MJSON::PP -E 'is_deeply decode_json(qq{{"a":true}})->{a}, \1'

cpanel-1:
	docker-compose run app perl -M'Test::More "no_plan"' -MJSON::PP -M'Cpanel::JSON::XS ()' -E 'is_deeply decode_json(qq{{"a":true}})->{a}, \1' || true

json-pp-strigify:
	docker-compose run app perl -Moverload -MJSON::PP -E 'say overload::Method(JSON::PP::false, q{""}) || "Not overloaded"'

cpanel-strigify:
	docker-compose run app perl -Moverload -MJSON::PP -M'Cpanel::JSON::XS ()' -E 'say overload::Method(JSON::PP::false, q{""}) || "Not overloaded"'
