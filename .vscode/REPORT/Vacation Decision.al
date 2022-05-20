report 50109 VacationDecision
{
    DefaultLayout = RDLC;
    RDLCLayout = './adna.rdlc';
    //EnableExternalAssemblies = 'Yes';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem1; Employee)
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(Year; Year)
            {
            }
            column(BrojDokumenta; BrojDokumenta)
            {
            }
            column(DatumRjesenja; DatumRjesenjaT)
            {
            }
            column(Company_logo; CompanyInformation.Picture)
            {
            }
            dataitem(DataItem5; "Vacation Grounds")
            {
                RequestFilterFields = "Employee No.";
                column(WorkEXpDays; "Days based on Work experience")
                {

                }
                column(YearofVac; "Year")
                {

                }
                column(NumberofDays; "Number of days")
                {

                }
                column(Disability; "Days based on Disability")
                {
                }
                column(StartFirstpart; "Starting Date of I part")
                {
                }
                column(EndFirstpart; "Ending Date of I part")
                {
                }
                column(Start2part; "Starting Date of II part")
                {
                }
                column(End2part; "Ending Date of II part")
                {
                }
                column(Position; Position)
                {
                }
                column(Sector; Sector)
                {

                }
            }

            trigger OnPreDataItem()
            begin
                DatumRjesenjaT := FORMAT(DatumRjesenja, 0, '<Day,2>.<Month,2>.<Year4>.');
                Year := FORMAT(DatumRjesenja, 0, '<Year4>.');
                DataItem5.CalcFields(Position, Sector);

            end;




        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(BrojDokumenta; BrojDokumenta)
                {
                    Caption = 'Broj dokumenta';
                }
                field(DatumRjesenja; DatumRjesenja)
                {
                    Caption = 'Datum rješenja';
                }
            }
        }

        actions
        {

        }
    }

    labels
    {
    }

    var

        Year: Text;
        DatumRjesenja: Date;
        DatumRjesenjaT: Text;
        BrojDokumenta: Text;
        CompanyInformation: Record "Company Information";
}

