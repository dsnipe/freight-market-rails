# Freight market
## Description
We have market where vessel owners and cargo owners can communicate each other and make deals.
Customers put their positions in system.
There are 2 types of it:
* **PositionVessel**
* **PositionCargo**  

After customers put their position, they can find opposite, that match to their parameters (I simplify that part to one parameter, but here may be very complex algorithm). Also users can search use any others type of searching (not implemented).
If one user find matched position, he send **Offer**, that create **Discussion**, where users chat each others.

## Gems
* [Mongoid](http://mongoid.org/en/mongoid/index.html) – DB communication
* [Wisper](https://github.com/krisleech/wisper) (pub/sub communication)
* API on [Grape](https://github.com/intridea/grape)

## Communication with others software (API on Node.JS, for example – WIP)
Messaging on RabbitMQ
Gems:
* [Bunny](https://github.com/ruby-amqp/bunny) – RabbitMQ client
* [sneakers](https://github.com/jondot/sneakers) – watching on Rabbit queses. Can work same as Sidekiq.
Idea from [blog post](http://codetunes.com/2014/event-sourcing-on-rails-with-rabbitmq/)

TODO:
* build node.js api and communicate with rails (req/res type communication)

## Disclaimer
I made this code as an example of the some (not all) principles of DDD in RoR. And how RoR can be part of SOA architecture. 
