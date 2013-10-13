Boris Bikes
===========

### Makers Academy - Week 3

This task was set by Enrique Comba Riepenhausen (@ecomba) whilst learning to
code at [Makers Academy](http://www.makersacademy.com). The purpose was to build
an object oriented model based on the Travel for London Cycle Hire scheme.

I paired with [Yuin Huang](https://github.com/yuin23). We started by writing CRC cards
(Class, Responsibilities, Collaborators) with pen and paper. Then we used RSpec
to develop our model using TDD.

This model could be improved by drying out the cross-cutting concern of
storing bikes in the Station, Garage and Van classes. A `BikeStore` module might
be appropriate.

Here are our CRC cards:

#### Class Bike

| Responsibilities     | Collaborators |
| :------------------- | :------------ |
| has a serial number  | User          |
|                      | Van           |
|                      | Station       |
|                      | Garage        |

#### Class User

| Responsibilities                   | Collaborators |
| :--------------------------------- | :------------ |
| have a name                        | Station       |
| hire a Bike from a Station         | Bike          |
| ride a Bike                        |               |
| return a Bike to a Station         |               |
| break a Bike                       |               |
| report a broken Bike to a Station  |               |

#### Class Station

| Responsibilities                                 | Collaborators |
| :----------------------------------------------- | :------------ |
| has a location                                   | Bike          |
| has a given capacity of Bikes                    | User          |
| can be full                                      | Van           |
| can have a number of spaces                      | Garage        |
| passes on reports of broken Bikes to the Garage  |               |
| know which Bikes it has                          |               |
| allow a working Bike to be hired                 |               |
| prevent broken Bikes from being hired            |               |
| allow the Van to collect broken Bikes            |               |

#### Garage

| Responsibilities                                 | Collaborators |
| :----------------------------------------------- | :------------ |
| receive reports of broken Bikes from Stations    | Van           |
| order the Van to collect broken Bikes            | Station       |
| receive broken Bikes from the Van                | Bike          |
| fix broken Bikes                                 |               |
| have a stock of Bikes                            |               |
| put working Bikes on the Van                     |               |
| send the Van out to Stations with working Bikes  |               |
