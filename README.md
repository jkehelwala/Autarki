# Autarki
NetLogo Peer to Peer simulation for Consensus Protocol
- Can only return json serializable values to NetLogo

## Shortcomings
- Each voter can additionally sign the voter list before transmitting 
but this is too much processing for the single threaded simulation
- Modeling connection diversity
    - temp method used to quickly propagate transactions, Because otherwise 
    simulation hangs. Implementation is there, but wait times will have to be used sparingly 

## TODO
- [ ] Request Blockchain from the most available peer instead of the one who propogated 
- [ ] Currently picks transactions obtained before proposer tick time.

## TODO Immediately
- [x] Fix infinite Loop propagate_block_to_peer Check the respective Netlogo Code as well 
- [x] `is_down` not working issue. (Fixed via clear_schedule)          

## Generic

Game repeated in sets of "n" consensus rounds. 
- After "n" successful or unsuccessful blocks, a new investment period, new round
- number of malicious players tolerable by name  0 < m < n/2 
  
