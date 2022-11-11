#!/bin/bash
#createdb -U postgres rates
psql -h localhost -U postgres < rates.sql
