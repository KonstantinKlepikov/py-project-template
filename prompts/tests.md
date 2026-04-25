# Tests python Guide

## Testing

- Framework: **pytest** with `pytest-asyncio`
- Use test classes for groups of tests, that wraps similar tests (e.g. tests for one function or one method of class)
- Follow **AAA** pattern: Arrange-Act-Assert (can use comments for sections)
- One case - one test. Dont combine many test cases in one test
- Naming: `test_<what>_<scenario>` (e.g. `test_create_flight_raises_on_duplicate_callsign`)
- Start any doc strings of tests with word `Test` (e.g. `"""Test function_name success with raw data"""`)
- Add docstrings to test classes
- Fixtures in `conftest.py` at appropriate level; use factory fixtures for varied object creation
- Max fixture chain depth: 3
- Mock **external** dependencies
- Use `from _pytest.monkeypatch import MonkeyPatch` for mock functions
- Use `from types import MethodType` for mock class methods
- Start name of mock function with word `mock_` (e.g. `async def mock_some(*args, **kwargs)`)
- For integration tests: use real infrastructure services in docker-compose containers if it is declared, and mock other services
- For unit test mock everything objects for test isolations
- All imports from test directories must be relative
- Minimize documentation in tests — at most a one-line comment
- When using `parametrize` with random data, always provide explicit `ids`
- Define function scope fictures in `conftest.py`
- In tests, when mocking, use specific `# type: ignore[attr-defined]` not bare `# type: ignore`
- Use comments for clearly test fail prints (e.g. `assert this is that, f'wrong result: {this} not equal {that}'`)

```python
async def test_create_flight_with_valid_data(
    flight_service: FlightService,
    valid_flight_data: FlightCreate,
) -> None:
    # Arrange
    expected_callsign = valid_flight_data.callsign

    # Act
    result = await flight_service.create(valid_flight_data)

    # Assert
    assert result.callsign == expected_callsign
```
