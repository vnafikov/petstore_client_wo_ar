# Client to petstore.swagger.io API
Without ActiveResource.

Examples:
```
PetstoreClient::Client.new.pet.get(id: 1)
PetstoreClient::Client.new(api_key: 'secret-key').pet.get(id: 1)
PetstoreClient::Client.new(api_key: 'secret-key').pet.get(:find_by_status)
PetstoreClient::Client.new(api_key: 'secret-key').pet.get(:find_by_status, status: :available)
PetstoreClient::Client.new(api_key: 'secret-key').pet.get(:find_by_status, status: %i[available pending sold])
```
