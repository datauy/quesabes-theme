# While testing manually from inside the theme do:
# ../tuderechoasaber/script/runner ../tuderechoasaber-theme/script/fetch_irekia_responses.rb

require File.dirname(__FILE__)+'/../lib/irekia_bridge'

# TODO: Filter to check the ones still waiting for response
events = InfoRequestEvent.find_by_sql(
      "select 
        ire.id, ir.title, ir.described_state, ire.event_type, ire.params_yaml, tags.value 
      from 
        info_request_events ire,
        info_requests ir,
        public_bodies pb, 
        has_tag_string_tags tags
      where
        tags.model_id = pb.id and
        ir.public_body_id = pb.id and
        ire.info_request_id = ir.id and
        (ire.event_type='followup_sent' or ire.event_type='sent') and
        tags.name = 'special_delivery'")

events.each do |event|
  question_id = event.params[:question_id]
  puts "Checking responses for event #{event.id} (#{event['title']}) => Irekia ID #{question_id}"
  IrekiaBridge.get_response(question_id)
end