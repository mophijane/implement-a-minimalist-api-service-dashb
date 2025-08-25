library(plumber)
library(jsonlite)

# Define API endpoint for service dashboard
api <- plumb("dashboard_api")

# GET /services - retrieve list of services
api$get("/services", function(req, res) {
  services <- list(
    list(name = "Service A", status = "UP"),
    list(name = "Service B", status = "DOWN"),
    list(name = "Service C", status = "UP")
  )
  res$status <- 200
  res-body <- toJSON(services, auto_unbox = TRUE)
})

# GET /services/:id - retrieve service details
api$get("/services/:id", function(req, res) {
  id <- req$args$id
  service <- list(
    name = paste0("Service ", id),
    status = sample(c("UP", "DOWN"), 1)
  )
  res$status <- 200
  res-body <- toJSON(service, auto_unbox = TRUE)
})

# POST /services - create new service
api$post("/services", function(req, res) {
  service <- req$body
  # Create new service (not implemented in this example)
  res$status <- 201
  res-body <- toJSON(list(message = "Service created successfully"))
})

# Run the API
api$run()