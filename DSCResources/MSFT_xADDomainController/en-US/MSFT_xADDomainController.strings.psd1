ConvertFrom-StringData @'
    ResolveDomainName = Resolving the domain name '{0}'. (ADDC0001)
    DomainPresent = The domain '{0}' is present. Looking for domain controllers. (ADDC0002)
    FoundDomainController = Found the domain controller '{0}' in the domain '{1}'. (ADDC0003)
    AlreadyDomainController = The current node '{0}' is already a domain controller for the domain '{1}'. (ADDC0004)
    NotDomainController = The current node '{0}' is not a domain controller. (ADDC0006)
    IsDomainController = The current node '{0}' is a domain controller for the domain '{1}'. (ADDC0007)
    MissingDomain = Current node could not find the domain '{0}'. (ADDC0008)
    Promoting = Promoting the current node to be a domain controller for the domain '{1}'. (ADDC0009)
    Promoted = The current node '{0}' has been promoted to a domain controller for the domain '{1}'. (ADDC0010)
    AddGlobalCatalog = Adding Global Catalog to the domain controller. (ADDC0011)
    RemoveGlobalCatalog = Removing Global Catalog from the domain controller. (ADDC0012)
#   MovingDomainController = Moving Domain Controller from site '{0}' to site '{1}'. (ADDC0013)
    FailedToFindSite = The site '{0}' could not be found in the domain '{1}'. (ADDC0014)
    TestingConfiguration = Determine the state of the domain controller on the current node '{0}' in the domain '{1}'. (ADDC0015)
    WrongSite = The domain controller is in the site '{0}', but expected it to be in the site '{1}'. (ADDC0016)
    ExpectedGlobalCatalogEnabled = The domain controller does not contain a Global Catalog, but it was expected to have a Global Catalog.
    ExpectedGlobalCatalogDisabled = The domain controller have a Global Catalog, but it was expected to not have a Global Catalog.
    ExpectedDomainController = Expected the node to be a domain controller, but did not get a domain controller object. (ADDC0017)
'@
