# App Rankings Mongoid api

### routes
### **GET** "/rankings/:date/apps"
  * **params**
    * `type` - options: `all`, `paid`, `free` (defaults to `all`)
    * `sort` - options: `downloads`, `revenue` (defaults to `downloads`)
    * `limit` - maximum number of items to return (defaults to `400`)