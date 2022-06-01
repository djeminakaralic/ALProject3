xmlport 50007 "Tax Deduction Amount"
{
    Direction = Import;
    FieldDelimiter = ',';
    FieldSeparator = ',';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement(Employee; Employee)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Employee';
                UseTemporary = false;
                textelement(JMB)
                {
                    MinOccurs = Zero;
                }
                textelement(Iznos)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin
                    Employee.SETFILTER("No.", '%1', JMB);
                    IF Employee.FIND('-') THEN BEGIN
                        IF EVALUATE(IznosInt, Iznos) THEN BEGIN
                            Employee.VALIDATE("Tax Deduction Amount", IznosInt);
                            Employee.MODIFY;
                        END;
                    END;
                end;
            }
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

    var
        IznosInt: Integer;
}

