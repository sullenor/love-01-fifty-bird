StateMachine = Class{}

--[[ Usage example:

      MyState = Class{__includes = BaseState}

      function MyState:init() end
      function MyState:render() end

      gStateMachine = StateMachine {
        stateName = function () return MyState() end
      }

    StateMachine is an abstraction, which allows us to split business logic
    between various state implementations: incapsulate all the logic inside
    specific state.

]]--

function StateMachine:init(states)
  self.empty = {
    enter = function () end,
    exit = function () end,
    render = function () end,
    update = function () end
  }

  self.states = states or {}
  self.current = self.empty
end

function StateMachine:change(stateName, values)
  assert(self.states[stateName]) -- check if the specified state exists
  -- call exit method for the current state
  self.current:exit()
  -- get new state with its methods through the function call
  self.current = self.states[stateName]()
  -- call enter for the new state
  self.current:enter(values)
end

function StateMachine:render()
  self.current:render()
end

function StateMachine:update(dt)
  self.current:update(dt)
end
