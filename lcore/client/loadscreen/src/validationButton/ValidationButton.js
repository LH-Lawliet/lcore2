import './ValidationButton.scss';


function ValidationButton(data) {
    return (
        <button
            onClick={data.onClick}
            id="validationButton"
        >
            Valider
        </button>
    )
}
export default ValidationButton;