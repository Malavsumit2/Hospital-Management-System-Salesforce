function validateInput() {
                var x = document.getElementById("numberInput").value;
                var text;
                if (isNaN(x) || x < 1 || x > 10) {
                    text = "Input not valid";
                    
                } else {
                    text = "Input OK";
                }
                document.getElementById("demo").innerHTML = text;
            }