
import sqlparse
print("Enter Query : ")
query = input()
query = query.strip(';')
# conevrt this into query tree


parsed_query = sqlparse.parse(sqlparse.format(
    query, keyword_case='upper'))[0].tokens
print('\n\n\nPARSED QUERY : ')
print(sqlparse.format(query, reindent=True, keyword_case='upper'))
print('\n\n-----------------------------------------------------------------------------------------\n\n')
