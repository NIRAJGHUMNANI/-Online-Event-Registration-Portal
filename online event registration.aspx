<%@ Page Language="C#" %>
<%@ Import Namespace="System.Text.RegularExpressions" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Event Registration</title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        }

        private bool CheckField(Label lbl, string txt, string regex, string emptyMsg, string errMsg)
        {
            if (string.IsNullOrWhiteSpace(txt))
            {
                lbl.Text = " " + emptyMsg;
                lbl.ForeColor = System.Drawing.Color.Red;
                return false;
            }
            if (!string.IsNullOrEmpty(regex) && !Regex.IsMatch(txt, regex))
            {
                lbl.Text = " " + errMsg;
                lbl.ForeColor = System.Drawing.Color.Red;
                return false;
            }
            lbl.Text = " ✔";
            lbl.ForeColor = System.Drawing.Color.Green;
            return true;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Validate Input Fields
            bool v1 = CheckField(lblValName, TextBox1.Text.Trim(), @"^[a-zA-Z\s]{3,50}$", "Please enter Name.", "Name is incorrect (Letters only, min 3 chars).");
            bool v2 = CheckField(lblValEnr, TextBox2.Text.Trim(), @"^\d{10,12}$", "Please enter Enrollment Number.", "ENR NO is incorrect (10 to 12 digits required).");
            bool v3 = CheckField(lblValCourse, TextBox3.Text.Trim(), @"^[a-zA-Z\s]{2,20}$", "Please enter Course.", "Course is incorrect (Letters only, e.g., BCA).");
            bool v4 = CheckField(lblValClass, TextBox4.Text.Trim(), @"^[a-zA-Z0-9\s\-]{1,10}$", "Please enter Class.", "Class format is incorrect.");
            bool v5 = CheckField(lblValGrNo, TextBox5.Text.Trim(), @"^\d{3,10}$", "Please enter GR Number.", "GR NO is incorrect (3 to 10 digits required).");
            bool v6 = CheckField(lblValCity, DropDownList1.SelectedValue, "", "Please select a City.", "");
            bool v7 = CheckField(lblValEvent, DropDownList2.SelectedValue, "", "Please select an Event.", "");

            // Validate Gender
            bool vGender = RadioButton2.Checked || RadioButton3.Checked;
            lblValGender.Text = vGender ? " ✔" : " Please select Gender.";
            lblValGender.ForeColor = vGender ? System.Drawing.Color.Green : System.Drawing.Color.Red;

            // Validate Date
            bool vDate = false;
            DateTime d;
            if (string.IsNullOrWhiteSpace(TextBox6.Text))
            {
                lblValDate.Text = " Please select an Event Date.";
                lblValDate.ForeColor = System.Drawing.Color.Red;
            }
            else if (!DateTime.TryParse(TextBox6.Text, out d))
            {
                lblValDate.Text = " Invalid Event Date format.";
                lblValDate.ForeColor = System.Drawing.Color.Red;
            }
            else if (d.Date < DateTime.Today)
            {
                lblValDate.Text = " Event Date cannot be in the past.";
                lblValDate.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lblValDate.Text = " ✔";
                lblValDate.ForeColor = System.Drawing.Color.Green;
                vDate = true;
            }

            // Display Results Page if All Fields are Valid
            if (v1 && v2 && v3 && v4 && v5 && v6 && v7 && vGender && vDate)
            {
                lblName.Text = TextBox1.Text.Trim();
                lblEnr.Text = TextBox2.Text.Trim();
                lblCourse.Text = TextBox3.Text.Trim();
                lblClass.Text = TextBox4.Text.Trim();
                lblGrNo.Text = TextBox5.Text.Trim();
                lblGender.Text = RadioButton2.Checked ? "MALE" : "FEMALE";
                lblCity.Text = DropDownList1.SelectedValue;
                lblEvent.Text = DropDownList2.SelectedValue;
                lblDate.Text = TextBox6.Text.Trim();

                pnlForm.Visible = false;
                pnlDetails.Visible = true;
            }
            else
            {
                lblStatus.Text = "Please correct the errors marked in red above.";
                lblStatus.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            pnlForm.Visible = true;
            pnlDetails.Visible = false;
        }
    </script>
</head>
<body style="font-family: Arial, sans-serif; margin: 20px;">
    <form id="form1" runat="server">

        <!-- REGISTRATION FORM -->
        <asp:Panel ID="pnlForm" runat="server" style="font-weight: 700;">
            <p>
                <strong>NAME : </strong>
                <asp:TextBox ID="TextBox1" runat="server" Height="22px" Width="180px"></asp:TextBox>
                <asp:Label ID="lblValName" runat="server" style="font-weight: normal;"></asp:Label>
            </p>

            <p>
                <strong>ENR NO : </strong>
                <asp:TextBox ID="TextBox2" runat="server" Height="22px" Width="180px"></asp:TextBox>
                <asp:Label ID="lblValEnr" runat="server" style="font-weight: normal;"></asp:Label>
            </p>

            <p>
                <strong>COURSE : </strong>
                <asp:TextBox ID="TextBox3" runat="server" Height="22px" Width="180px"></asp:TextBox>
                <asp:Label ID="lblValCourse" runat="server" style="font-weight: normal;"></asp:Label>
            </p>

            <p>
                <strong>CLASS : </strong>
                <asp:TextBox ID="TextBox4" runat="server" Height="22px" Width="180px"></asp:TextBox>
                <asp:Label ID="lblValClass" runat="server" style="font-weight: normal;"></asp:Label>
            </p>

            <p>
                <strong>GR NO : </strong>
                <asp:TextBox ID="TextBox5" runat="server" Height="22px" Width="180px"></asp:TextBox>
                <asp:Label ID="lblValGrNo" runat="server" style="font-weight: normal;"></asp:Label>
            </p>

            <p>
                <strong>GENDER : </strong>
                <asp:RadioButton ID="RadioButton2" runat="server" GroupName="GN" Text="MALE" />
                &nbsp;&nbsp;
                <asp:RadioButton ID="RadioButton3" runat="server" GroupName="GN" Text="FEMALE" />
                <asp:Label ID="lblValGender" runat="server" style="font-weight: normal;"></asp:Label>
            </p>

            <p>
                <strong>CITY : </strong>
                <asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem Value="">-- Select City --</asp:ListItem>
                    <asp:ListItem>RAJKOT</asp:ListItem>
                    <asp:ListItem>AHMEDABAD</asp:ListItem>
                    <asp:ListItem>SURAT</asp:ListItem>
                    <asp:ListItem>PORBANDAR</asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="lblValCity" runat="server" style="font-weight: normal;"></asp:Label>
            </p>

            <p>
                <strong>EVENT NAME : </strong>
                <asp:DropDownList ID="DropDownList2" runat="server">
                    <asp:ListItem Value="">-- Select Event --</asp:ListItem>
                    <asp:ListItem>AI SMASHER</asp:ListItem>
                    <asp:ListItem>CODING NINJA</asp:ListItem>
                    <asp:ListItem>HACK IT DOWN</asp:ListItem>
                    <asp:ListItem>SWEET SERVER</asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="lblValEvent" runat="server" style="font-weight: normal;"></asp:Label>
            </p>

            <p>
                <strong>EVENT DATE : </strong>
                <asp:TextBox ID="TextBox6" runat="server" Height="25px" TextMode="Date" Width="180px"></asp:TextBox>
                <asp:Label ID="lblValDate" runat="server" style="font-weight: normal;"></asp:Label>
            </p>

            <p>
                <asp:Button ID="Button1" runat="server" Text="SUBMIT" OnClick="Button1_Click" />
            </p>

            <p>
                <asp:Label ID="lblStatus" runat="server" style="font-weight: normal;"></asp:Label>
            </p>
        </asp:Panel>

        <!-- SUBMITTED DETAILS VIEW -->
        <asp:Panel ID="pnlDetails" runat="server" Visible="false">
            <h2 style="color: green;">Registration Successful!</h2>
            <h3>Submitted Details:</h3>
            <table border="1" cellpadding="8" cellspacing="0" style="border-collapse: collapse; width: 400px;">
                <tr>
                    <td><strong>Name</strong></td>
                    <td><asp:Label ID="lblName" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td><strong>Enrollment No</strong></td>
                    <td><asp:Label ID="lblEnr" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td><strong>Course</strong></td>
                    <td><asp:Label ID="lblCourse" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td><strong>Class</strong></td>
                    <td><asp:Label ID="lblClass" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td><strong>GR No</strong></td>
                    <td><asp:Label ID="lblGrNo" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td><strong>Gender</strong></td>
                    <td><asp:Label ID="lblGender" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td><strong>City</strong></td>
                    <td><asp:Label ID="lblCity" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td><strong>Event Name</strong></td>
                    <td><asp:Label ID="lblEvent" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td><strong>Event Date</strong></td>
                    <td><asp:Label ID="lblDate" runat="server"></asp:Label></td>
                </tr>
            </table>
            <br />
            <asp:Button ID="btnBack" runat="server" Text="Register Another" OnClick="btnBack_Click" />
        </asp:Panel>

    </form>
</body>
</html>