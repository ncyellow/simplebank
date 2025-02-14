package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	_ "github.com/jackc/pgx/v5"
	_ "github.com/lib/pq"
)

const (
	dbDriver = "postgres"
	dbSource = "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable"
)

var (
	testQueries *Queries
	testDB      *sql.DB
	testStore   *Store
)

func TestMain(m *testing.M) {
	var err error
	testDB, err = sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	testQueries = New(testDB)
	testStore = NewStore(testDB)
	os.Exit(m.Run())
}
