package com.partymaker.mvc.service.user;

import com.partymaker.mvc.dao.event.EventDAO;
import com.partymaker.mvc.dao.user.UserDao;
import com.partymaker.mvc.model.whole.UserEntity;
import com.partymaker.mvc.model.whole.event;
import com.partymaker.mvc.service.billing.BillingService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * Created by anton on 09/10/16.
 */
@Service("userService")
@Transactional()
public class UserServiceImpl implements UserService<UserEntity> {

    private static final DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    private static Date date;

    private static final Logger logger = Logger.getLogger(UserServiceImpl.class);

    @Autowired
    private UserDao userDao;

    @Autowired
    private EventDAO eventDAO;

    @Autowired
    BillingService billingService;

    @Override
    public UserEntity findUserBuId(Long id) {
        return (UserEntity) userDao.findById(id);
    }

    @Override
    public List<UserEntity> findAllUsers() {
        return userDao.findAll();
    }

    @SuppressWarnings("unchecked")
    @Override
    public void deleteUser(Long id) {
        userDao.deleteUser(id);
    }

    @Override
    public void saveUser(UserEntity user) {
        date = new Date();
        user.setCreatedDate(dateFormat.format(date));

        logger.info("saving billing");
        billingService.saveBilling(user.getBilling());
        logger.info("saved billing");
        user.setEnable(true);

        try {
            logger.info("try to get  billing");
            user.setBilling(billingService.findByCard(user.getBilling().getCard_number()));
        } catch (Exception e) {
            logger.info("Failed to fetch billing due to ", e);
        }
        userDao.save(user);
    }

    /* since we use the Transaction,
     don't need to update, just set fetched user with new parameters */
    @Override
    public void updateUser(UserEntity user) {
        UserEntity user1 = (UserEntity) userDao.findById(user.getId_user());

    }

    @Override
    public void addEvent(String userEmail, event event) {
        UserEntity entity = (UserEntity) userDao.findByField(userEmail, userEmail);

        event eventEntity = (event) eventDAO.getByCode(event.getTime());

        if (Objects.nonNull(entity) && Objects.nonNull(eventEntity)) {
            entity.getEvents().add(eventEntity);
        }
    }

    @Override
    public UserEntity findUserByEmail(String value) {
        return (UserEntity) userDao.findByField("email", value);
    }

    @Override
    public boolean isExist(String email) {

        return Objects.nonNull(userDao.findByField(email, email));
    }

    @Override
    public boolean isExistByName(String string) {
        return Objects.nonNull(userDao.findByName(string));
    }

    public ResponseEntity<?> isExistUserRequiredFields(UserEntity user) {
        try {
            if (isExist(user.getEmail())) {
                return new ResponseEntity<Object>("User with such email is already exist", HttpStatus.IM_USED);
            }
            if (isExistByName(user.getUserName())) {
                return new ResponseEntity<Object>("User with such username is already exist", HttpStatus.IM_USED);
            }
            if (billingService.isExist(user.getBilling())) {
                return new ResponseEntity<Object>("User with current billing info is already exist", HttpStatus.IM_USED);
            }
            return null;
        } catch (Exception e) {
            logger.info("Error checking user due to ", e);
            return null;
        }
    }
}
