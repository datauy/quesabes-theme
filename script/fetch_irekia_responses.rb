# While testing manually from inside the theme do:
# ../tuderechoasaber/script/runner ../tuderechoasaber-theme/script/fetch_irekia_responses.rb

require File.dirname(__FILE__)+'/../lib/irekia_bridge'

# TODO: Filter to check only the ones still waiting for response. Harder than I initially thought,
# I think the best way is check described_state = 'waiting_response' and awaiting_description = false.
# Unless I'm wrong any other combination means something arrived. Now, the user could classify the
# response as 'I'm still waiting', in which case it's probably wasteful to recheck - because I think
# Irekia only replies once - but maybe it's more robust like this.
# In the meantime I'm ignoring requests that have responses already when fetching responses. Note that
# this relies on the assumption that Irekia replies only once ever.
events = InfoRequestEvent.find_by_sql(
      "select 
        ire.id, ir.id as ir_id, ir.title, ire.event_type, ire.params_yaml, tags.value 
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
  request = InfoRequest.find(event['ir_id'])
  if request.incoming_messages.size > 0
    puts "We already had a response, skipping request ##{request.id} (#{request.title})..."
    next
  end

  question_id = event.params[:question_id]
  puts "Checking responses for event #{event.id} (#{event['title']}) => Irekia ID #{question_id}"

  IrekiaBridge.get_response(request, question_id)
end
