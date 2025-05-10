The database is in the 3rd Normal form:

### 1NF(First Normal Form):
- All attributes in the database are atomic
- Every column in the database has single values
  
### 2NF(Second Normal Form):
- The DB is in the 1st Normal Form
- There are no partial dependencies in the database
- All the tables in the database use UUID as primary keys, so there are no composite keys. Thus, no partial dependencies
  
### 3NF(Third Normal Form):
- The DB is in 2NF
- There are no transitive dependencies in the database, i.e there are no non-prime attributes dependent on other non-prime attributes.
