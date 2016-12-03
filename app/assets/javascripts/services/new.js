class Service {
  constructor(jsonData){
    this.id = jsonData.id;
    this.service_name = jsonData.service_name;
    this.description = jsonData.description;
    this.start_time = jsonData.start_time;
    this.end_time = jsonData.end_time;
  }
  displayService(){
    const html = [
      `<h2>New Service</h2>`,
      '<ul>',
      `<li>Service Name: ${this.service_name}</li>`,
      `<li>Service Description: ${this.description}</li>`,
      `<li>Service Start Time: ${this.start_time}</li>`,
      `<li>Service End Time: ${this.end_time}</li>`,
      `<a href="/services">View Services</a>`,
      '</ul>'
    ].join('')
    return html;
  }
}//end Service

$(document).on('turbolinks:load', function() {

  $('#new_service').submit(function(event){

    event.preventDefault();
    $('.alert.alert-danger').remove();

    $.ajax({
      url: this.action,
      data: $(this).serialize(),
      dataType: "json",
      type: this.method,

      success: function(response){
        const service = new Service(response);
        $("form").html(service.displayService());
        $(".page-title").html("Service Successfully Created")
      },

      error: function(errorResponse){
        const error = $.parseJSON(errorResponse.responseText);
        const html = [
          '<div class="alert alert-danger alert-dismissible fade in" role="alert">',
          '<button type="button" class="close" data-dismiss="alert" aria-label="Close">',
          '<span aria-hidden="true">×</span>',
          '</button>',
          '<h4>Please fix the following errors:</h4>',
          '<ul id=js-error>'
        ]

        for (let errorMessage in error) {
          html.push(`<li>${errorMessage}</li>`);
        }
        html.push('</ul>', '</div>');

        // NOTE: place error message above the form
        $(".container.service.form").before(html.join(''));

      },// end error

      complete: function(){
        // NOTE: enable submit button after preventDefault()
        $('input[type="submit"]').prop('disabled', false);
      }

    });//end ajax()

  });//end submit()
});//end on('turbolinks:load')
