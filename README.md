# App Rankings Mongoid api

### routes
### **GET** "/rankings/:date/apps"
  * **params**
    * `type` - options: `paid`, `free` (defaults to `paid`)
    * `sort` - options: `downloads`, `revenue` (defaults to `downloads`)
    * `limit` - maximum number of items to return