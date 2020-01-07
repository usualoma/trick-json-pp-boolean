# trick-json-pp-boolean

Sample code of tricking JSON::PP::Boolean by Cpanel::JSON::XS

```
$ make run
make \
		json-pp-true \
		cpanel-true \
		json-pp-1 \
		cpanel-1 \
		json-pp-strigify \
		cpanel-strigify
docker-compose run app perl -M'Test::More "no_plan"' -MJSON::PP -E 'is_deeply decode_json(qq{{"a":true}})->{a}, JSON::PP::true'
ok 1
1..1
docker-compose run app perl -M'Test::More "no_plan"' -MJSON::PP -M'Cpanel::JSON::XS ()' -E 'is_deeply decode_json(qq{{"a":true}})->{a}, JSON::PP::true'
ok 1
1..1
docker-compose run app perl -M'Test::More "no_plan"' -MJSON::PP -E 'is_deeply decode_json(qq{{"a":true}})->{a}, \1'
ok 1
1..1
docker-compose run app perl -M'Test::More "no_plan"' -MJSON::PP -M'Cpanel::JSON::XS ()' -E 'is_deeply decode_json(qq{{"a":true}})->{a}, \1' || true
not ok 1
#   Failed test at -e line 1.
#     Structures begin differing at:
#          $got = '1'
#     $expected = SCALAR(0x55629cfd2848)
1..1
# Looks like you failed 1 test of 1.
docker-compose run app perl -Moverload -MJSON::PP -E 'say overload::Method(JSON::PP::false, q{""}) || "Not overloaded"'
Not overloaded
docker-compose run app perl -Moverload -MJSON::PP -M'Cpanel::JSON::XS ()' -E 'say overload::Method(JSON::PP::false, q{""}) || "Not overloaded"'
CODE(0x55746e1885d0)
```
