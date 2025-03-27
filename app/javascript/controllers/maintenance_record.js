$(document).on("submit", "#new-maintenance-record", function(e) {
    e.preventDefault();
  
    $.ajax({
      url: $(this).attr("action"),   // e.g. /users/:user_id/cars/:car_id/maintenance_records
      type: "POST",
      data: $(this).serialize(),     // Serialize form data
      dataType: "json",              // Expect JSON response
      success: function(response) {
        if (response.success) {
          alert("Record created successfully!");
          // Update the DOM, e.g. prepend the new record
        } else {
          alert("There was an error: " + response.errors.join(", "));
        }
      },
      error: function(xhr, status, error) {
        alert("AJAX error: " + error);
      }
    });
  });
  