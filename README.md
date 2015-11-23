## Mongoid-api

#### routes
**GET** "/rankings/:date/apps"
  * params
    * `type` - options: `paid`, `free`; default: `paid`
    * `sort` - options: `downloads`, `revenue`; default: `downloads`
    * `limit` - maximum number of items to return