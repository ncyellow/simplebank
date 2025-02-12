postgres:
	docker run --name pg17 -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres:17-alpine	
createdb:
	docker exec -it pg17 createdb --username=postgres --owner=postgres simple_bank
dropdb:
	docker exec -it pg17 dropdb --username=postgres simple_bank
migrateup:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
.PHONY: postgres createdb dropdb migrateup migratedown sqlc test

