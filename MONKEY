from collections import deque

class State:
    def __init__(self, monkey, box, banana, on_box, has_banana, path):
        self.monkey = monkey
        self.box = box
        self.banana = banana
        self.on_box = on_box
        self.has_banana = has_banana
        self.path = path


def is_goal(state):
    return state.has_banana


def get_next_states(state):
    next_states = []

    if state.monkey != state.box:
        new_state = State(state.box, state.box, state.banana,
                          state.on_box, state.has_banana,
                          state.path + ["Move monkey to box"])
        next_states.append(new_state)

    if state.monkey == state.box and state.box != state.banana:
        new_state = State(state.banana, state.banana, state.banana,
                          state.on_box, state.has_banana,
                          state.path + ["Push box to banana"])
        next_states.append(new_state)

    if state.monkey == state.box and not state.on_box:
        new_state = State(state.monkey, state.box, state.banana,
                          True, state.has_banana,
                          state.path + ["Climb the box"])
        next_states.append(new_state)

    if state.on_box and state.monkey == state.banana and not state.has_banana:
        new_state = State(state.monkey, state.box, state.banana,
                          state.on_box, True,
                          state.path + ["Grab banana"])
        next_states.append(new_state)

    return next_states


def bfs_monkey_banana():
    start = State("door", "window", "center", False, False, [])
    queue = deque([start])
    visited = set()

    while queue:
        state = queue.popleft()

        if state.has_banana:
            print("Goal reached using BFS!\n")
            print("Steps:")
            for step in state.path:
                print(step)
            return

        state_id = (state.monkey, state.box, state.on_box, state.has_banana)
        visited.add(state_id)

        for next_state in get_next_states(state):
            next_id = (next_state.monkey, next_state.box,
                       next_state.on_box, next_state.has_banana)

            if next_id not in visited:
                queue.append(next_state)


bfs_monkey_banana()
