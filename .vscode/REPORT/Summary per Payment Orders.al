report 50055 "Summary per Payment Orders"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Summary per Payment Orders.rdl';
    Caption = 'Sumarry per Payment Orders';

    dataset
    {
        dataitem(DataItem1; "Payment Order")
        {
            DataItemTableView = WHERE(Contributon = FILTER(<> ''),
                                      Iznos = FILTER(<> 0));
            RequestFilterFields = "Wage Header No.";
            column(Type; Type)
            {
            }
            column("Code"; Code)
            {
            }
            column(Contribution; Contributon)
            {
            }
            column(Amount; Iznos)
            {
            }
            column(CompanyName; CompInfo.Name)
            {
            }
            column(Address; CompInfo.Address)
            {
            }
            column(PostCode; CompInfo."Post Code")
            {
            }
            column(City; CompInfo.City)
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(WageCalculationType_PaymentOrder; "Wage Calculation Type")
            {
            }
            column(User; USERID)
            {
            }
            column(RDate; RDate)
            {
            }
            column(Name; Name)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CompInfo.GET;
                RDate := TODAY;
                Name := '';

                IF Type = 0 THEN BEGIN
                    IF t_Entity.GET(Code) THEN
                        Name := t_Entity.Description;
                END;
                IF Type = 1 THEN BEGIN
                    Canton.SETFILTER(Code, Code);
                    IF Canton.GET(Code) THEN
                        Name := Canton.Description;
                END;
                IF Type = 2 THEN BEGIN
                    IF Mun.GET(Code) THEN
                        Name := Mun.Name;
                END;
                CompInfo.CALCFIELDS(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompInfo: Record "Company Information";
        RDate: Date;
        Mun: Record Municipality;
        Canton: Record Canton;
        Name: Text[150];
        t_Entity: Record Entity;
}

