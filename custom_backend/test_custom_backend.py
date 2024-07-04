import pytest
from unittest.mock import MagicMock, patch
from custom_backend import CustomBackend

class TestCustomBackendSingleConstant:

    @pytest.fixture
    def mock_args(self):
        args = MagicMock()
        args.const = ["n=4"]
        args.log_args = {"name": "test_logger"}
        return args

    @pytest.fixture
    def backend(self, mock_args):
        with patch('custom_backend.ClingoBackend._init_ctl'), \
             patch('custom_backend.ClingoBackend._ground'), \
             patch('clingo.Control'):
            return CustomBackend(mock_args)

    def test_initialization(self, backend):
        """
        Test if the backend initializes with the correct value for constant n.
        """
        assert backend.current_constants == {"n": 4}

    def test_update_constant(self, backend):
        """
        Test if update_constant method updates the constant 'n' and triggers necessary updates.
        """
        with patch.object(backend, '_refresh_constant_arguments') as mock_refresh, \
             patch.object(backend, '_outdate') as mock_outdate, \
             patch.object(backend, '_init_ctl') as mock_init_ctl, \
             patch.object(backend, '_ground') as mock_ground:
            success, message = backend.update_constant("n", 5)
        assert backend.current_constants["n"] == 5
        mock_refresh.assert_called_once()
        mock_outdate.assert_called_once()
        mock_init_ctl.assert_called_once()
        mock_ground.assert_called_once()
        assert success
        assert "updated successfully" in message

    def test_no_change_on_same_value(self, backend):
        """
        Ensure that no methods are triggered if the constant 'n' is updated to its existing value.
        """
        with patch.object(backend, '_refresh_constant_arguments') as mock_refresh, \
             patch.object(backend, '_outdate') as mock_outdate, \
             patch.object(backend, '_init_ctl') as mock_init_ctl, \
             patch.object(backend, '_ground') as mock_ground:
            success, message = backend.update_constant("n", 4)
        mock_refresh.assert_not_called()
        mock_outdate.assert_not_called()
        mock_init_ctl.assert_not_called()
        mock_ground.assert_not_called()
        assert success
        assert "updated successfully" in message

    def test_update_constant_from_ui(self, backend):
        """
        Test if update_constant method successfully updates a constant from UI input.
        """
        with patch.object(backend, '_refresh_constant_arguments') as mock_refresh, \
             patch.object(backend, '_outdate') as mock_outdate, \
             patch.object(backend, '_init_ctl') as mock_init_ctl, \
             patch.object(backend, '_ground') as mock_ground:
            success, message = backend.update_constant("n", "5")
        assert backend.current_constants["n"] == 5
        mock_refresh.assert_called_once()
        mock_outdate.assert_called_once()
        mock_init_ctl.assert_called_once()
        mock_ground.assert_called_once()
        assert success
        assert "updated successfully" in message

    def test_update_constant_from_ui_invalid_input(self, backend):
        """
        Test handling of invalid input via the UI for constant 'n'.
        """
        success, message = backend.update_constant("n", "not_a_number")
        assert not success
        assert "Invalid input" in message
