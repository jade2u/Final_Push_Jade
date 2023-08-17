{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "obj_tab_game_manager",
  "eventList": [
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,},
  ],
  "managed": true,
  "overriddenProperties": [],
  "parent": {
    "name": "Objects",
    "path": "folders/Objects.yy",
  },
  "parentObjectId": null,
  "persistent": false,
  "physicsAngularDamping": 0.1,
  "physicsDensity": 0.5,
  "physicsFriction": 0.2,
  "physicsGroup": 1,
  "physicsKinematic": false,
  "physicsLinearDamping": 0.1,
  "physicsObject": false,
  "physicsRestitution": 0.1,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsShapePoints": [],
  "physicsStartAwake": true,
  "properties": [
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"discard_x","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"x + 350","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"hand_x_offset","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"room_width * (1/14)","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"computer_hand_y","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"room_height / 4.4","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"player_hand_y","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"room_height * 0.63","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"hand_x","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"room_width * (6 / 14)","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"comp_flip_wait","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"50","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"clear_state_wait","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"120","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"move_timer_max","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"30","varType":0,},
  ],
  "solid": false,
  "spriteId": null,
  "spriteMaskId": null,
  "visible": true,
}